pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- https://twitter.com/TRASEVOL_DOG/status/1027601491920601088

fillp(23130)z=cos::_::cls()g=t()/9w="1224499aaff777"for i=0,1,.004 do
l=16+2*z(i*3+z(g))x=l*z(i)y=l*sin(i)for k=0,3 do
o=k/4+z(i-g)*z(g)/2-g+i/2p=sin(o)+2s=z(o)+2
if(s>p)for n=0,3 do line(64+x*s+n%2,64+y*s+n/2,64+x*p+n%2,64+y*p+n/2,'0x'..sub(w,1,(s-p)*11))end
end end
flip()goto _