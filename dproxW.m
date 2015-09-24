function s1 = dproxW(x)
global N0 MTraj K MR CorM delta;

  function y = minu(v0)
  y=1-v0;
  end;
    
  function y = plu(v0)
  y=-(1-v0);
  end;
    
    
i00 =(N0+1)*N0/2+1;
i01=(N0+1)*N0/2+N0;
InVec = x(i00:i01);                                    %   Filling 1st colum of trajectory by Init conditions

MTraj(1:N0,1)=InVec;                                % disp(x);
for i=1:N0
  MR(i, i)=x(i);
end;

i0=N0+1;
for i = 2:N0
  for j = 1:i-1
  MR(i, j)=x(i0);
  i0=i0+1;
  end;
end;


% Cycle
Rep = false;
% Current position
CurP=1;      
while not(Rep) 

     for j=1:N0
       s0=0;            
      for i = 1: j-1                                % before diagonal
      switch MR(j, i)
            case {1, 3, 7}                              % (-, *) relation 
        s0=s0+minu(MTraj(i, CurP));
          case {2, 4, 8}                                    % (+, *) relation 
        s0=s0+plu(MTraj(i, CurP))   ; 
        end;   
      end;
      
      switch MR(j, j)                                  % on diagonal
            case {1}                                       % (-, *) relation 
              s0=s0+minu(MTraj(j, CurP));

            case {2}                                    % (+, *) relation 
              s0=s0+plu(MTraj(j, CurP))  ;  
      end;   
      
      for i = j+1:N0                               % bellow diagonal
        switch MR(i, j)
          case {1, 6, 8}                              % (-, *) relation 
              s0=s0+minu(MTraj(i, CurP));
          case {2, 5, 7}                                    % (+, *) relation 
              s0=s0+plu(MTraj(i, CurP))  ;              
            
        end;   
      end;

     if s0<-delta
            MTraj(j, CurP+1) = max(MTraj(j, CurP)-1, 1);
     elseif (s0>= -delta) & (s0 <= delta)
            MTraj(j, CurP+1) = MTraj(j, CurP);
     elseif s0>= delta 
            MTraj(j, CurP+1) = min(MTraj(j, CurP)+1, K);    
     end;
      
     end;
CurP=CurP+1;          

% Checking for repetition

Sfin = MTraj(:, CurP);
for i = 1:CurP-1 
  Sbeg = MTraj(:, i);
if norm(Sbeg-Sfin)==0     % Repetition !!
  Rep=true;
  Ibeg = i;
  break;
end;
  
end;
end;

if Ibeg+1==CurP 
  s1=N0*(N0-1)*2;
else
  MVar=var(MTraj(:, Ibeg:CurP-1)');
  if min(MVar)==0
    s1=N0*(N0-1)*2;
  else
    Mco=corr(MTraj(:, Ibeg:CurP-1)', 'type', 'Spearman');
    s1=0;
    for i=1:N0-1
      for j= i+1:N0
        s1=s1+(Mco(i, j)-CorM(i, j))^2;
      end;      
    end;
    
    
  end;
  
  
end;

end