clear 'all'
%Open serial port for communication with arduino
s = serial('COM3');     %change com port accroding to your connection
set(s,'BaudRate',9600,'DataBits',8,'Parity','none','InputBufferSize',1);
fopen(s)
s.ByteOrder = 'bigEndian';

%Always keep some delay to let arduino boot
pause(0.1);

%Dummy figure to terminate the infinite loop when required
hf=figure; 

j=1;
t=1;
k=0;
interv=100;
%stringr(100,6)= [zeros];
%stringp(100,6)= [zeros];
%stringy(100,6)= [zeros];

while 1

    data = fread(s);

    if data =='S' %start byte
         data = fread(s);
            if data == 'T' %start byte
                
                %roll angle 
                for i = 1:1:6
                    stringr(j,i)=fread(s);;                 
                end
                
                
                %pitch angle
                for i=1:1:6
                    stringp(j,i)=fread(s);;                 
                end
                
                %yaw angle
                for i=1:1:6
                    stringy(j,i)=fread(s);;                 
                end
                
                angle(j,1)=str2num(char(stringr(j,:)));%+(10*rand);      %roll
                angle(j,2)=str2num(char(stringp(j,:)));      %pitch
                angle(j,3)=str2num(char(stringy(j,:)));      %yaw
     
     
                plot (angle(:,1));
                axis ([interv-100, interv , -90 , 90 ]);
                grid
                t = t + 1;
                %drawnow ;
            end
    end
    
 %convert the recived ascii string into the float numbers   
  
     
     
 

 

 if t== interv
       %interv=interv+100
 end 
   
 %set the packet limit to 100
 j=j+1;
 if j>=100
     j=1
     t=1
     clearvars angle string ;
     clf
 end
 
 
   %exit when 'q' key is pressed
    if strcmp(get(hf,'currentcharacter'),'q')
        fclose(s)
        close(hf)
       break
    end
    
    figure(hf) 
    drawnow
end

close
delete(s)
clear s