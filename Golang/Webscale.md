# Load Balancer
## Architecture
- Keep a list of app server, forward the request to a server and move onto the next one. After interating through the entire list start from the beginning.
    - This is called the **round robin** strategy

### Provider registration
- Inform the load balancer when a provider comes online
- Inform the load balancer when a provider goes offline
- Heartbeat checks by the load balancer to make sure the service providers are still online (In case of sudden outages of providers) 

## Universal Provider vs. Microservice Provider
- Universal service provider can accept any service that the client sends to the load balancer
- Microservice providers accepts a subset of all the services available to the client
    - The load balancer needs to be aware what each providers are capable of