# CPEE Complex Rest

CPEE parameters are by default simple parameters, i.e., all parameters are
application/x-www-form-urlencoded as if you would send them from an HTML form.

In order to send files (i.e., application/json or multipart/form-encoded) in a
convenient way (alabeit with some overhead) use this service. It is usable as a
cpee endpoint, and allows synchronous requests. It acts as a proxy, so a small
performance impact will be measurable.

Alternatively in plain CPEE use special parameter name/value pairs to send very
custom requests.

* Header - name: __H_name, value: headername, e.g.: __H_content-type: application/json
* File - name: __C_name, value: mimetype;payload, e.g.: __C_json: application/json;["a",2]
* Simple Query - name: __Q_name, value: payload, e.g.: __C_test: 3 resulting in ?test=4
* Simple Body - name: __B_name, value: payload, e.g.: __C_test: 4 resulting in test=4 in the body

If only one File, and no simple body or query parameters are given, then the
Plain CPEE behavior is to just set the content-type header, and the content-id
header with the name. If multiple File parameters or a mix between simple body
and file parameters is given, then multipart is used.

This service behaves similarely: one parameter creates a plain
body/content-type request, multiple parameters create a multipart request.

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
