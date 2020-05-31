server
    {
      listen 80;
      server_name www.dcssn.com;
      location / {
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://47.92.69.112:8080;
      }
    }
 
  server
    {
      listen 80;
      server_name www.xhxf119.com;
      location / {
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://47.92.69.112:8081;
      }
    }
