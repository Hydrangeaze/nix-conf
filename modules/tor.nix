{pkgs, ...}:
{
   services.tor = {
      enable = true;
      enableGeoIP = false;
      
      torsocks.enable = true;

      client = {
         enable = true;
         socksListenAddress = {
            IsolateDestAddr = true;
            addr = "127.0.0.1";
            port = 9063;
         };

      };
      settings = {
        UseBridges = true;
        ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/lyrebird"; 
        Bridge = [
         "obfs4 217.182.104.236:21951 DD5099D019A3C46E8A47B3C2A4A0CF0A2A1652DE cert=O7lB7mA1NaGJalb0ZkPUlbPFOwO5ctd4GiefKCpjhX5vXKfmMWfa16q5Os06JVv3h7RvGw iat-mode=0"
         "obfs4 57.128.77.211:55292 B5A94026BE1374ED828E7F90B96ABAB2FA5F3766 cert=kuSBqiuzCHW2jlw5+wenky4CRrfbrjBxpUVN4NrQVRnIMjNgP+z3TwLCJI7JNjxGLPtGKg iat-mode=0"
         "obfs4 71.237.132.115:9002 02CF4A4B20778B05D4B22D0B5B27BF45BD3FDFC5 cert=/hJ7CSntMsrtrgqCuHDB50KwON484UCjfZfyeDeOTiDV+ZAPZKesTOaW9I9GjXkzccZwWQ iat-mode=0"
         "obfs4 129.159.242.16:30242 45680D8DEDD44399153E017A6B6833790484B4BC cert=zTi9kgTE+9bhHucOT/5J9cpIRN8KIoJv/WTSQj1ymcCkx8AGoOYX3a+bqDGb56BlQ5tkPQ iat-mode=0" 
        ];
      };
   };
}
