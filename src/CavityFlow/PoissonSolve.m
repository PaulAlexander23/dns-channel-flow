function p = PoissonSolve(p0,rhs,i)

global Rp Ap Pp
global xLen yLen
global dx dy

%...V-cycles
p0 = p0(:);
rhs = rhs(:);

rn  = norm(rhs - Ap{1,i}*p0);
ic  = 0;
p   = p0(:);

while ( (rn > 1e-9) && (ic < 15) )
    p  = MGVp(1,p,rhs,i);
    r  = rhs - Ap{1,i}*p;
    rn = norm(r);
    ic = ic + 1;
    %rhs = rhs - sum(r)*(dx/0.64)*(dy/0.32); <-----?
    %fprintf('iter %i (p)resnorm %g\n',ic,rn)
%     rr(ic) = norm(r);
end

if (ic >= 15)
    disp('max iter')
end

%fprintf('iter %i (p)resnorm %g\n',ic,rn)

%    figure;
%    semilogy(rr,'-o'); grid on
%    xlabel('Iteration');
%    ylabel('log(Residual)');
%    title('The Logarithm of the Residual against number of V cycles');

p = reshape(p,64,32);