##RouterOS v6
/ip route
add dst-address=0.0.0.0/8 type=blackhole comment=Bogons
add dst-address=127.0.0.0/8 type=blackhole comment=Bogons
add dst-address=169.254.0.0/16 type=blackhole comment=Bogons
add dst-address=192.0.2.0/24 type=blackhole comment=Bogons
add dst-address=198.18.0.0/15 type=blackhole comment=Bogons
add dst-address=198.51.100.0/24 type=blackhole comment=Bogons
add dst-address=224.0.0.0/3 type=blackhole comment=Bogons
##RouterOS v7
/ip route
add dst-address=0.0.0.0/8 blackhole comment=Bogons
add dst-address=127.0.0.0/8 blackhole comment=Bogons
add dst-address=169.254.0.0/16 blackhole comment=Bogons
add dst-address=192.0.2.0/24 blackhole comment=Bogons
add dst-address=198.18.0.0/15 blackhole comment=Bogons
add dst-address=198.51.100.0/24 blackhole comment=Bogons
add dst-address=224.0.0.0/3 blackhole comment=Bogons