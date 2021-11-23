/opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password password
/opt/jboss/keycloak/bin/kcadm.sh create users -s username=falk.hartmann@sciota.io -s enabled=true -r demo
/opt/jboss/keycloak/bin/kcadm.sh set-password -r demo --username falk.hartmann@sciota.io --new-password "**********"
