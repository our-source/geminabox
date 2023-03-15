[![Docker Pulls](https://img.shields.io/docker/pulls/oursource/geminabox.svg)](https://hub.docker.com/r/oursource/geminabox/)
[![Github Stars](https://img.shields.io/github/stars/our-source/geminabox.svg?label=github%20%E2%98%85)](https://github.com/our-source/geminabox/)
[![Github Stars](https://img.shields.io/github/contributors/our-source/geminabox.svg)](https://github.com/our-source/geminabox/)

# Gem in a BOX

This docker service is image to provide a easy private gem server.
Uploads and deletes are protected by a authorization token. It allows unauthorized downloads.

## Environment variables

__HTTP_AUTHORIZATION__
  * secret token

## Kubernetes example

```yaml
---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:

  name: gemdata-rook-ceph-block
spec:
  storageClassName: rook-ceph-block
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---

apiVersion: v1
kind: Service
metadata:
  name: geminabox
  labels:
    app: geminabox
spec:
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: geminabox

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: geminabox
spec:
  # Stop old container before starting new one
  # The storage block used does allow only one access
  strategy:
    type: Recreate
    rollingUpdate: null
  selector:
    matchLabels:
      app: geminabox
  replicas: 1
  template:
    metadata:
      labels:
        app: geminabox
    spec:
      containers:
      - name: geminabox
        image: oursource/geminabox:v1.7.0
        imagePullPolicy: IfNotPresent
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        env:
        - name: AUTH_TOKEN
          value: some-secret-key # REPLACE THIS value!!
        - name: RUBYGEMS_STORAGE
          value: /data
        ports:
        - containerPort: 8080
        volumeMounts:
        - mountPath: /data
          name: gemdata-rook-ceph-block
      volumes:
      - name: gemdata-rook-ceph-block
        persistentVolumeClaim:
          claimName: gemdata-rook-ceph-block

---

apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: geminabox-ingress
  annotations:
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/whitelist-source-range: 172.31.0.0/16
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
spec:
  rules:
  - host: geminabox.example.com
    http:
      paths:
      - backend:
          serviceName: geminabox
          servicePort: 80
  tls:
  - hosts:
    - geminabox.example.com
    secretName: geminabox
```
