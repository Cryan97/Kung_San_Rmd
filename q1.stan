 
data {
  int<lower=1> N;
  vector[N] height;
  vector[N] weight;
  int<lower=1> N_new;
  vector[N_new] weight_new;
}
parameters {
  real alpha;
  real beta;
  real<lower=0,upper=50> sigma;
}
model {
  vector[N] mu = alpha + beta * weight;  // Could move to 'transformed parameters' later, so that mu can be outputted etc.
  target += normal_lpdf(height | mu, sigma);
  target += normal_lpdf(alpha | 178, 20);
  target += normal_lpdf(beta | 0, 10);
}
generated quantities {
  vector[N_new] y_pred;
  for (n in 1:N_new){
    y_pred[n] = normal_rng(alpha + beta*weight_new[n], sigma);
  }
}