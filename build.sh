cd dns
./dns.sh
cd ..
docker build --no-cache=true -t lancache:0.1 .
docker rm cache
docker run -it --name="cache" -v /home/fouad/cache:/home/cache -p 80:80 -p 192.168.8.4:53:53/udp  lancache:0.1
