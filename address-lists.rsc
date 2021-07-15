#Variables globales
:global redespublicas; :global publicasdentrodelared; :global redesdeorigenpermitidas;
#
:global testvelocidadlb;:global bgplb;:global dnslb;:global snmplb;:global winboxlb;:global apilb;
:global sshlb;:global httplb;:global ntplb;:global radiuslb;:global sockslb;:global l2tplb;
:global pptplb;:global grelb;:global ipseclb;:global webproxylb;
#
:global testvelocidadln;:global bgpln;:global dnsln;:global snmpln;:global winboxln;:global apiln;
:global sshln;:global httpln;:global ntpln;:global radiusln;:global socksln;:global l2tpln;
:global pptpln;:global greln;:global ipsecln;:global webproxyln;
##Menu address-list
/ip firewall address-list
##Redes que se permiten navegar
/ip firewall address-list remove [find list=F_OrigenesPermitidos]
:do {add address=10.0.0.0/8 list=F_OrigenesPermitidos} on-error={
    :put "INFO - El address-list address=10.0.0.0/8 list=F_OrigenesPermitidos ya existe o no se puede crear"
}
:do {add address=172.16.0.0/12 list=F_OrigenesPermitidos} on-error={
    :put "INFO - El address-list address=172.16.0.0/12 list=F_OrigenesPermitidos ya existe o no se puede crear"
}
:do {add address=192.168.0.0/16 list=F_OrigenesPermitidos} on-error={
    :put "INFO - El address-list address=192.168.0.0/16 list=F_OrigenesPermitidos ya existe o no se puede crear"
}
:do {add address=100.64.0.0/10 list=F_OrigenesPermitidos} on-error={
    :put "INFO - El address-list address=192.168.0.0/16 list=F_OrigenesPermitidos ya existe o no se puede crear"
}
##Redes que se permiten navegar personalizadas
:if ([:pick $redesdeorigenpermitidas] != "") do={
    :foreach alpp in=$redesdeorigenpermitidas do={
        :do {/ip firewall address-list add list=F_OrigenesPermitidos address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_OrigenesPermitidos ya existe o no se puede crear";
        }
    }
}
##Redes publicas propias
/ip firewall address-list remove [find list=FN_RedesPublicasPropias]
:if ([:pick $redespublicas] != "") do={
    :foreach alpp in=$redespublicas do={
        :do {/ip firewall address-list add list=FN_RedesPublicasPropias address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=FN_RedesPublicasPropias ya existe o no se puede crear"
        }
    }
    :foreach alpp in=$redespublicas do={
        :do {/ip firewall address-list add list=F_OrigenesPermitidos address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_OrigenesPermitidos ya existe o no se puede crear"
        }
    }
}
##Publicas dentro de la red a bloquear
/ip firewall address-list remove [find list=F_ProteccionPublicasDentroDeLaRed]
:if ([:pick $publicasdentrodelared] != "") do={
    :foreach alpp in=$publicasdentrodelared do={
        :do {/ip firewall address-list add list=F_ProteccionPublicasDentroDeLaRed address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ProteccionPublicasDentroDeLaRed ya existe o no se puede crear"
        }
    }
}
##TestVelocidad
/ip firewall address-list remove [find list=F_ListaNegraTestVelocidad]
:if ([:pick $testvelocidadln] != "") do={
    :foreach alpp in=$testvelocidadln do={
        :do {/ip firewall address-list add list=F_ListaNegraTestVelocidad address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaTestVelocidad ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaTestVelocidad]
:if ([:pick $testvelocidadlb] != "") do={
    :foreach alpp in=$testvelocidadlb do={
        :do {/ip firewall address-list add list=F_ListaBlancaTestVelocidad address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaTestVelocidad ya existe o no se puede crear"
        }
    }
}
##BGP
/ip firewall address-list remove [find list=F_ListaNegraBGP]
:if ([:pick $bgpln] != "") do={
    :foreach alpp in=$bgpln do={
        :do {/ip firewall address-list add list=F_ListaNegraBGP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaBGP ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaBGP]
:if ([:pick $bgplb] != "") do={
    :foreach alpp in=$bgplb do={
        :do {/ip firewall address-list add list=F_ListaBlancaBGP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaBGP ya existe o no se puede crear"
        }
    }
}
##DNS
/ip firewall address-list remove [find list=F_ListaNegraDNS]
:if ([:pick $dnsln] != "") do={
    :foreach alpp in=$dnsln do={
        :do {/ip firewall address-list add list=F_ListaNegraDNS address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaDNS ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaDNS]
:if ([:pick $dnslb] != "") do={
    :foreach alpp in=$dnslb do={
        :do {/ip firewall address-list add list=F_ListaBlancaDNS address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaDNS ya existe o no se puede crear"
        }
    }
}
##SNMP
/ip firewall address-list remove [find list=F_ListaNegraSNMP]
:if ([:pick $snmpln] != "") do={
    :foreach alpp in=$snmpln do={
        :do {/ip firewall address-list add list=F_ListaNegraSNMP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaSNMP ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaSNMP]
:if ([:pick $snmplb] != "") do={
    :foreach alpp in=$snmplb do={
        :do {/ip firewall address-list add list=F_ListaBlancaSNMP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaSNMP ya existe o no se puede crear"
        }
    }
}
##Winbox
/ip firewall address-list remove [find list=F_ListaNegraWinbox]
:if ([:pick $winboxln] != "") do={
    :foreach alpp in=$winboxln do={
        :do {/ip firewall address-list add list=F_ListaNegraWinbox address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaWinbox ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaWinbox]
:if ([:pick $winboxlb] != "") do={
    :foreach alpp in=$winboxlb do={
        :do {/ip firewall address-list add list=F_ListaBlancaWinbox address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaWinbox ya existe o no se puede crear"
        }
    }
}
##API
/ip firewall address-list remove [find list=F_ListaNegraAPI]
:if ([:pick $apiln] != "") do={
    :foreach alpp in=$apiln do={
        :do {/ip firewall address-list add list=F_ListaNegraAPI address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaAPI ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaAPI]
:if ([:pick $apilb] != "") do={
    :foreach alpp in=$apilb do={
        :do {/ip firewall address-list add list=F_ListaBlancaAPI address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaAPI ya existe o no se puede crear"
        }
    }
}
##HTTP
/ip firewall address-list remove [find list=F_ListaNegraHTTP]
:if ([:pick $httpln] != "") do={
    :foreach alpp in=$httpln do={
        :do {/ip firewall address-list add list=F_ListaNegraHTTP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaHTTP ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaHTTP]
:if ([:pick $httplb] != "") do={
    :foreach alpp in=$httplb do={
        :do {/ip firewall address-list add list=F_ListaBlancaHTTP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaHTTP ya existe o no se puede crear"
        }
    }
}
##SSH
/ip firewall address-list remove [find list=F_ListaNegraSSH]
:if ([:pick $sshln] != "") do={
    :foreach alpp in=$sshln do={
        :do {/ip firewall address-list add list=F_ListaNegraSSH address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaSSH ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaSSH]
:if ([:pick $sshlb] != "") do={
    :foreach alpp in=$sshlb do={
        :do {/ip firewall address-list add list=F_ListaBlancaSSH address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaSSH ya existe o no se puede crear"
        }
    }
}
##NTP
/ip firewall address-list remove [find list=F_ListaNegraNTP]
:if ([:pick $ntpln] != "") do={
    :foreach alpp in=$ntpln do={
        :do {/ip firewall address-list add list=F_ListaNegraNTP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaNTP ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaNTP]
:if ([:pick $ntplb] != "") do={
    :foreach alpp in=$ntplb do={
        :do {/ip firewall address-list add list=F_ListaBlancaNTP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaNTP ya existe o no se puede crear"
        }
    }
}
##RADIUS
/ip firewall address-list remove [find list=F_ListaNegraRADIUS]
:if ([:pick $radiusln] != "") do={
    :foreach alpp in=$radiusln do={
        :do {/ip firewall address-list add list=F_ListaNegraRADIUS address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaRADIUS ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaRADIUS]
:if ([:pick $radiuslb] != "") do={
    :foreach alpp in=$radiuslb do={
        :do {/ip firewall address-list add list=F_ListaBlancaRADIUS address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaRADIUS ya existe o no se puede crear"
        }
    }
}
##SOCKS
/ip firewall address-list remove [find list=F_ListaNegraSOCKS]
:if ([:pick $socksln] != "") do={
    :foreach alpp in=$socksln do={
        :do {/ip firewall address-list add list=F_ListaNegraSOCKS address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaSOCKS ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaSOCKS]
:if ([:pick $sockslb] != "") do={
    :foreach alpp in=$sockslb do={
        :do {/ip firewall address-list add list=F_ListaBlancaSOCKS address=$alpp
        } on-error={
        :put "INFO - El address-list address=$alpp list=F_ListaBlancaSOCKS ya existe o no se puede crear"
        }
    }
}
##L2TP
/ip firewall address-list remove [find list=F_ListaNegraL2TP]
:if ([:pick $l2tpln] != "") do={
    :foreach alpp in=$l2tpln do={
        :do {/ip firewall address-list add list=F_ListaNegraL2TP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaL2TP ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaL2TP]
:if ([:pick $l2tplb] != "") do={
    :foreach alpp in=$l2tplb do={
        :do {/ip firewall address-list add list=F_ListaBlancaL2TP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaL2TP ya existe o no se puede crear"
        }
    }
}
##PPTP
/ip firewall address-list remove [find list=F_ListaNegraPPTP]
:if ([:pick $pptpln] != "") do={
    :foreach alpp in=$pptpln do={
        :do {/ip firewall address-list add list=F_ListaNegraPPTP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaPPTP ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaPPTP]
:if ([:pick $pptplb] != "") do={
    :foreach alpp in=$pptplb do={
        :do {/ip firewall address-list add list=F_ListaBlancaPPTP address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaPPTP ya existe o no se puede crear"
        }
    }
}
##GRE
/ip firewall address-list remove [find list=F_ListaNegraGRE]
:if ([:pick $greln] != "") do={
    :foreach alpp in=$greln do={
        :do {/ip firewall address-list add list=F_ListaNegraGRE address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaGRE ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaGRE]
:if ([:pick $grelb] != "") do={
    :foreach alpp in=$grelb do={
        :do {/ip firewall address-list add list=F_ListaBlancaGRE address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaGRE ya existe o no se puede crear"
        }
    }
}
##IPSEC
/ip firewall address-list remove [find list=F_ListaNegraIPSEC]
:if ([:pick $ipsecln] != "") do={
    :foreach alpp in=$ipsecln do={
        :do {/ip firewall address-list add list=F_ListaNegraIPSEC address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaIPSEC ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaIPSEC]
:if ([:pick $ipseclb] != "") do={
    :foreach alpp in=$ipseclb do={
        :do {/ip firewall address-list add list=F_ListaBlancaIPSEC address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaIPSEC ya existe o no se puede crear"
        }
    }
}
##WebProxy
/ip firewall address-list remove [find list=F_ListaNegraWebProxy]
:if ([:pick $webproxyln] != "") do={
    :foreach alpp in=$webproxyln do={
        :do {/ip firewall address-list add list=F_ListaNegraWebProxy address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaNegraWebProxy ya existe o no se puede crear"
        }
    }
}
/ip firewall address-list remove [find list=F_ListaBlancaWebProxy]
:if ([:pick $webproxylb] != "") do={
    :foreach alpp in=$webproxylb do={
        :do {/ip firewall address-list add list=F_ListaBlancaWebProxy address=$alpp
        } on-error={
            :put "INFO - El address-list address=$alpp list=F_ListaBlancaWebProxy ya existe o no se puede crear"
        }
    }
}