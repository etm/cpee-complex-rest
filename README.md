# CPEE Complex Rest

CPEE parameters are by default simple parameters, i.e., all parameters are
application/x-www-form-urlencoded as if you would send them from an HTML form.

In order to send special headers, files (i.e., multipart/form-encoded), or have
fine-grained control wheter a parameter is a query or a body parameter we
provide this service. It is usable as a cpee endpoint, and allows synchronous
requests. It acts as a proxy, so a small performance impact will be measurable.

To install the service go to the commandline

```bash
 gem install cpee-complex-rest
 cpee-cr new cr
 cd cr
 ./complex-rest start
```

The service is running under port 9301. If this port has to be changed (or the
host, or local-only access, ...), create a file instatiation.conf and add one
or many of the following yaml keys:

```yaml
 :port: 9301
 :host: cpee.org
 :bind: 127.0.0.1
```
