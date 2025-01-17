# CPEE Complex Rest

CPEE parameters are by default simple parameters, i.e., all parameters are
application/x-www-form-urlencoded as if you would send them from an HTML form.

In order to send files (i.e., application/json or multipart/form-encoded) use this
service. It is usable as a cpee endpoint, and allows synchronous
requests. It acts as a proxy, so a small performance impact will be measurable.

Alternatively in plain CPEE use special parameter name/value pairs to send very
custom requests.

* name: __H_name, value: headername, e.g.: __H_content-type: application/json
* name: __C_name, value: mimetype;payload, e.g.: __C_json: application/json;["a",2]

To install the service go to the commandline

```bash
 gem install cpee-complex-rest
 cpee-complex-rest new complex-rest
 cd cr
 ./complex-rest start
```

The service is running under port 9311. If this port has to be changed (or the
host, or local-only access, ...), create a file instatiation.conf and add one
or many of the following yaml keys:

```yaml
 :port: 9311
 :host: cpee.org
 :bind: 127.0.0.1
```
