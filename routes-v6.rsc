:global bogons10; :global bogons172; :global bogons192; :global bogons100;
##RouterOS v6
/ip route remove [find comment=Bogons]
/ip route
add dst-address=0.0.0.0/8 type=blackhole comment=Bogons
:if ($bogons10 = 1) do={add dst-address=10.0.0.0/8 type=blackhole comment=Bogons}
:if ($bogons172 = 1) do={add dst-address=172.16.0.0/12 type=blackhole comment=Bogons}
:if ($bogons192 = 1) do={add dst-address=192.168.0.0/16 type=blackhole comment=Bogons}
:if ($bogons100 = 1) do={add dst-address=100.64.0.0/10 type=blackhole comment=Bogons}
add dst-address=127.0.0.0/8 type=blackhole comment=Bogons
add dst-address=169.254.0.0/16 type=blackhole comment=Bogons
add dst-address=192.0.0.0/24 type=blackhole comment=Bogons
add dst-address=192.0.2.0/24 type=blackhole comment=Bogons
add dst-address=192.88.99.0/24 type=blackhole comment=Bogons
add dst-address=198.18.0.0/15 type=blackhole comment=Bogons
add dst-address=198.51.100.0/24 type=blackhole comment=Bogons
add dst-address=203.0.113.0/24 type=blackhole comment=Bogons
add dst-address=224.0.0.0/4 type=blackhole comment=Bogons
add dst-address=240.0.0.0/4 type=blackhole comment=Bogons