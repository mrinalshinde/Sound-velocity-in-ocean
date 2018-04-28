vm=5:5:30;
for n=1:6
for i=1:1000
a(i)=isotropic(i,vm(n),-999,-999,-999);
end
j=1000:1000:10^6;
for k=1:1000
l=k+1000;
a(l)=isotropic(j(k),vm(n),-999,-999,-999);
end
 
switch n
    case 1
        b=a;
    case 2
        c=a;
    case 3
        d=a; 
    case 4
        e=a; 
    case 5
        g=a;
    case 6
        h=a;
        
end
end
ii=0.001:0.001:1;
kk=1:1000;
f=[ii kk];
semilogx(f,b,'-o',f,c,'-o',f,d,'-o',f,e,'-o',f,g,'-o',f,h,'-o','LineWidth',2)
legend('wind speed=5 Knots','wind speed=10 Knots',...
    'wind speed=15 Knots','wind speed=20 Knots',...
    'wind speed=25 Knots','wind speed=30 Knots')
grid
title('Ambient Noise')
xlabel('Frequency [KHz]')
ylabel('Level [dB]')


% Turbulence noise:
function [nlturb]=turb(f)
          nlturb=30-30*log10(f./1000);
end
% Far ship (traffic) noise:
function [nltraff]=traffic(f)
nltraff=10*log10((3e+8)./(1+(1e+4*((f./1000).^4))));
end
% Thermal noise (molecular agitation):
function [nltherm]=thermal(f)
         nltherm=-15+20*log10(f./1000);
end
% Sea state noise:
function [sea]=seastate(f,vm)
sea=40+10*log10((vm.^2)./(1+(f./1000).^(5/3)));
end
% Isotropic noise level:
function [nliso]=isotropic(f,vm,rain,bio,self)
nliso=10*log10((10.^(.1*turb(f)))+(10.^(.1*traffic(f)))+(10.^(.1*seastate(f ,vm)))+(10.^(.1*thermal(f)))...
    +(10.^(.1*rain))+(10.^(.1*bio))+(10.^(.1*self)));
end