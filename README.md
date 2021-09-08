# opa-bundle

## opa eval

Using a directory path
```
> opa eval --bundle ./bundle --input ./input.json 'data.envoy.authz.allow' --format pretty

true
```

Using a bundle file built with tar
```
> tar czvf bundle1.tar.gz --directory ./bundle .
> opa eval --bundle ./bundle1.tar.gz --input ./input.json 'data.envoy.authz.allow' --format pretty

true
```

Using a bundle file built with opa
```
> cd ./bundle
> opa build . --output ../bundle2.tar.gz
> cd ..
> opa eval --bundle ./bundle2.tar.gz --input ./input.json 'data.envoy.authz.allow' --format pretty

true
```

## opa run
Using a directory path
```
# In your first terminal
> opa run --server --bundle ./bundle --log-level debug

# In a second terminal (using the v0 API endpoint)
> curl http://localhost:8181/v0/data/envoy/authz/allow --data @input.json
true

# Using the v1 API rather than v0
> curl http://localhost:8181/v1/data/envoy/authz/allow --data @v1-input.json
{"result":true}
```

Using a bundle file built with tar
```
> tar czvf bundle1.tar.gz --directory ./bundle .

# In your first terminal
> opa run --server --bundle ./bundle1.tar.gz --log-level debug

# In a second terminal (using the v0 API endpoint)
> curl http://localhost:8181/v0/data/envoy/authz/allow --data @input.json
true

# Using the v1 API rather than v0
> curl http://localhost:8181/v1/data/envoy/authz/allow --data @v1-input.json
{"result":true}

```

Using a bundle file built with opa
```
> cd ./bundle
> opa build . --output ../bundle2.tar.gz
> cd ..

# In your first terminal
> opa run --server --bundle ./bundle2.tar.gz --log-level debug

# In a second terminal (using the v0 API endpoint)
> curl http://localhost:8181/v0/data/envoy/authz/allow --data @input.json
true

# Using the v1 API rather than v0
> curl http://localhost:8181/v1/data/envoy/authz/allow --data @v1-input.json
{"result":true}
```
