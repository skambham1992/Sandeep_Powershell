<?php
$ldap_dn = "cn=Sandeep Reddy Kambham,ou=Users,ou=VizagIncubation,dc=corp,dc=innominds,dc=com";
	$ldap_password = "Inno123$";
	
	$ldap_con = ldap_connect("corp.innominds.com");
	
	ldap_set_option($ldap_con, LDAP_OPT_PROTOCOL_VERSION, 3);
	
 if ($ldap_con) { 
  $ldapbind = ldap_bind($ldap_con, $ldap_dn, $ldap_password)  or die("Couldn't bind to AD!"); 
 } 

 $dn = "dc=corp,dc=innominds,dc=com"; 
 $filter="(objectClass=organizationalunit)"; 
 $justthese = array("dn", "ou"); 
 $sr=ldap_search($ldap_con, $dn, $filter, $justthese); 
 $info = ldap_get_entries($ldap_con, $sr); 

for ($i=0; $i < $info["count"]; $i++) { 
        echo $info[$i]["dn"]."<br>"; 
} 
 ldap_free_result($sr); 
 ldap_unbind($ldap_con);
 ?>