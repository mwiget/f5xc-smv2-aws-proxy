# f5xc-smv2-aws-proxy

Create F5XC SMv2 single node AWS site, bootstrapped via  squid proxy
with SSL inspection and self signed certificate.

```
                          +-----+
..........................| igw |.............................
. aws vpc                 +-----+                            .
.                                                            .
.                      proxy                                 .
.  +-----------+  10.1.1.100:3128  +----------------------+  .
.  | F5XC Site |  - - - - - - - -> | squid ssl inspection |  .
.  +-----------+                   +----------------------+  .
.                                                            .
..............................................................
```

## Deployment

Clone repo

```
git clone https://github.com/mwiget/f5xc-smv2-aws-proxy.git
cd f5xc-smv2-aws-proxy
```

Copy and edit terraform.tfvars:

```
cp terraform.tfvars.example terraform.tfvars
```

Deploy TF:

```
terraform init
terraform plan
terraform apply
```

Terraform output will provide public IP addresses of the F5XC ce and squid instance:

```
terraform output
 ip_address = [
 {
     "mw-aws-proxy-1a-m0" = "xx.xxx.xx.xx"
       
 },
 {     
     "mw-aws-proxy-1a-slo-squid" = "xx.xxx.xxx.xx"
       
 },    
 
 ]
 site1 = <sensitive>
```

The generated self signed cert are in /etc/squid/cert/

```
root@ip-10-1-1-100:/home/ubuntu# ls -l /etc/squid/cert/
total 16
-rw-r--r-- 1 proxy proxy  879 Oct 19 07:37 ca.der
-rw------- 1 proxy proxy 1704 Oct 19 07:37 ca.key
-rw-r--r-- 1 proxy proxy 1245 Oct 19 07:37 ca.pem
-rw-r--r-- 1 proxy proxy  424 Oct 19 07:38 dhparam.pem
```


test proxy from either instance via curl and look for `CN=Self-signed CA`:

```
# curl --proxy http://10.1.1.100:3128 https://ipinfo.io --insecure -v
*   Trying 10.1.1.100:3128...
* Connected to 10.1.1.100 (10.1.1.100) port 3128 (#0)
* allocate connect buffer!
* Establish HTTP proxy tunnel to ipinfo.io:443
> CONNECT ipinfo.io:443 HTTP/1.1
> Host: ipinfo.io:443
> User-Agent: curl/7.76.1
> Proxy-Connection: Keep-Alive
> 
< HTTP/1.1 200 Connection established
< 
* Proxy replied 200 to CONNECT request
* CONNECT phase completed!
* ALPN, offering h2
* ALPN, offering http/1.1
*  CAfile: /etc/pki/tls/certs/ca-bundle.crt
* TLSv1.0 (OUT), TLS header, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* CONNECT phase completed!
* CONNECT phase completed!
* TLSv1.2 (IN), TLS header, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (OUT), TLS header, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS header, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS header, Finished (20):
* TLSv1.2 (IN), TLS header, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS header, Unknown (23):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.2 (IN), TLS header, Unknown (23):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS header, Unknown (23):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.2 (IN), TLS header, Unknown (23):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.2 (OUT), TLS header, Unknown (23):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server did not agree to a protocol
* Server certificate:
*  subject: CN=ipinfo.io
*  start date: Oct  1 14:07:07 2024 GMT
*  expire date: Dec 30 14:07:06 2024 GMT
*  issuer: C=US; ST=SanJose; O=IT; CN=Self-signed CA
*  SSL certificate verify result: self-signed certificate in certificate chain (19), continuing anyway.
* TLSv1.2 (OUT), TLS header, Unknown (23):
> GET / HTTP/1.1
> Host: ipinfo.io
> User-Agent: curl/7.76.1
> Accept: */*
> 
* TLSv1.2 (IN), TLS header, Unknown (23):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.2 (IN), TLS header, Unknown (23):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* old SSL session ID is stale, removing
* TLSv1.2 (IN), TLS header, Unknown (23):
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< access-control-allow-origin: *
< Content-Length: 331
< Content-Type: application/json; charset=utf-8
< Date: Sat, 19 Oct 2024 08:26:30 GMT
< referrer-policy: strict-origin-when-cross-origin
< x-content-type-options: nosniff
< x-frame-options: SAMEORIGIN
< x-xss-protection: 1; mode=block
< Via: 1.1 google, 1.1 ip-10-1-1-100 (squid/6.6)
< strict-transport-security: max-age=2592000; includeSubDomains
< Alt-Svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
< Cache-Status: ip-10-1-1-100;fwd=stale;detail=match
< Connection: keep-alive
< 
* TLSv1.2 (IN), TLS header, Unknown (23):
{
  "ip": "xx.xx.xx.xx",
  "hostname": "ec2-xx-xx-xx-xx.us-west-1.compute.amazonaws.com",
  "city": "San Jose",
  "region": "California",
  "country": "US",
  "loc": "37.3394,-121.8950",
  "org": "AS16509 Amazon.com, Inc.",
  "postal": "95103",
  "timezone": "America/Los_Angeles",
  "readme": "https://ipinfo.io/missingauth"
* Connection #0 to host 10.1.1.100 left intact
```
