haproxy:
  pkg.installed:
    - names:
      - haproxy

/etc/haproxy/haproxy.cfg:
  file.managed:
    - contents: |
        global 
          maxconn 4096 
          log 127.0.0.1 local0 debug
  
        defaults
          log global
          option httplog
          option dontlognull
          option forwardfor
          maxconn 20
          timeout connect 5s
          timeout client 5min
          timeout server 5min
  
        frontend http-in
          bind *:80
          bind *:443 ssl crt /usr/local/etc/haproxy/ssl/server.pem
          mode http
          redirect scheme https if !{ ssl_fc } # Redirect http requests to https
          use_backend jenkins if { path_beg /jenkins/ }
  
        backend jenkins
          server jenkins1 127.0.0.1:8080
          mode http
          http-request set-header X-Forwarded-Port %[dst_port]
          http-request add-header X-Forwarded-Proto https if { ssl_fc }
          reqrep ^([^\ :]*)\ /(.*)     \1\ /\2
          acl response-is-redirect res.hdr(Location) -m found
          rspirep ^Location:\ (http)://127.0.0.1:8080/(.*)   Location:\ https://jenkins.coyhile.com:443/\2  if response-is-redirect
  
