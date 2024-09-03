# CPEE Eval Ruby

CPEE can utilize multiple script languages when it comes to evaluationg
conditions, excuting prepare/finalize/update/rescue or script tasks.

Evaluating the expresions/code is delegated to an external service. This
projects implements the ruby version of this functionality.

The advantage of this approach is, so that you can isolate the evaluation on
separate servers for security and load-balancing reasons.

To install the service go to the commandline

```bash
 gem install cpee-eval-ruby
 cpee-eval-ruby new eval
 cd eval
 ./eval-ruby start
```

The service is running under port 9302. If this port has to be changed (or the
host, or local-only access, ...), create a file eval-ruby.conf and add one
or many of the following yaml keys:

```yaml
 :port: 9302
 :bind: 127.0.0.1
```
