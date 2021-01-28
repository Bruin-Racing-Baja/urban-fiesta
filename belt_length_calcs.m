L = 39.99469*.0254; % [m] belt cord length
c = 10.5*.0254; % [m] primary-secondary center-to-center distance
r_prim_min = .75*.0254; % [m] primary sheave minimum radius
r_prim_max = 3.5*.0254; % [m] primary sheave maximum radius
r_sec_min = 2.02*.0254; % [m] secondary sheave minimum radius
r_sec_max = 4.6*.0254; % [m] secondary sheave maximum radius

n = 100;
r_prim = linspace(r_prim_min, r_prim_max, n); % vector of primary radius values
r_sec = zeros(size(r_prim));
r_sec(1) = r_sec_max;

syms r1 r2;

Leq = pi*(r1 + r2) + 2*(r2 - r1)*asin((r2 - r1)/c) + 2*sqrt(c^2 - (r2 - r1).^2) - L;
for i = 2:length(r_prim)
    
%     r1 = r_prim(i);
    r_sec(i) = vpasolve(subs(Leq, r1, r_prim(i)), r2, r_sec(i-1));

end
r_sec(1) = vpasolve(subs(Leq, r1, r_prim(1)), r2, r_sec(1));
r_sec = abs(r_sec);

error = zeros(size(r_prim));
for i = 1:length(r_prim)
    error(i) = pi*(r_prim(i) + r_sec(i)) + 2*(r_sec(i) - r_prim(i))*asin((r_sec(i) - r_prim(i))/c) + 2*sqrt(c^2 - (r_sec(i) - r_prim(i)).^2) - L;
end
error = error/.0254;

figure(7);
plot(1:length(r_prim), error);
grid on;
ylabel('length error [in]');

r_sec = r_sec/.0254;
r_prim = r_prim/.0254;

cvt_rat = r_sec./r_prim;

figure(6);
subplot(311);
plot(r_prim, r_sec);
grid on;
xlabel('primary radius [in]');
ylabel('secondary radius [in]');
subplot(312);
plot(r_prim, cvt_rat);
grid on;
xlabel('primary radius [in]');
ylabel('cvt ratio');
subplot(313);
plot(r_sec, cvt_rat);
grid on;
xlabel('secondary radius [in]');
ylabel('cvt ratio');
