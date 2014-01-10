t = 0;
x = 0 ;
interv=1000;
hf=figure
while 1
 b = rand;	
 x = [ x, b ];
 plot (x);
 axis ([interv-1000 , interv , 0 , 1 ]);
 grid
 t = t + 1;
 drawnow ;

   if t== interv
       interv=interv+1000
   end
   
   %exit when 'q' key is pressed
    if strcmp(get(hf,'currentcharacter'),'q')
        close(hf)
       break
    end
    
    figure(hf) 
    drawnow
    
end
