## NGINX AND CERT-MANAGER SET UP

If using AKS v1.24 or later, add the following annotation to the NGINX ingress controller's service to fix health probe failures:

```service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: "/healthz"```

This resolves an issue where the Load Balancer's backend pool becomes unhealthy due to the default probe path (`/` or `127.0.0.1`) returning 404 errors. The issue arises because the ingress controller only routes traffic for specific hostnames, causing mismatched probe requests to fail. Use host-based routing and validate the probe path for a healthy configuration.

If the annotation is missing, you can patch the service to add it. Use the following command:
```bash
kubectl patch svc nginx-ingress-ingress-nginx-controller  -n ingress-nginx \
  -p '{"metadata": {"annotations": {"service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path": "/healthz"}}}'
```

[Github discussion ](https://github.com/Azure/AKS/issues/2903#issuecomment-1115720970)
[Stack Overflow](https://stackoverflow.com/questions/75247903/aks-ingress-nginx-ingress-controller-failing-to-route-by-host)



