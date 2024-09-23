 
data {
  int<lower=1> N;
  vector[N] height;
  vector[N] log_weight_c;
}
parameters {
  real alpha;
  real beta;
  real<lower=0,upper=50> sigma;
}
model {
  vector[N] mu = alpha + beta * log_weight_c;  // Could move to 'transformed parameters' later, so that mu can be outputted etc.
  target += normal_lpdf(height | mu, sigma);
  target += normal_lpdf(alpha | 178, 100);
  target += normal_lpdf(beta | 0, 10);
}
generated quantities {
  vector[N] y_pred;
  for (n in 1:N){
    y_pred[n] = normal_rng(alpha + beta*log_weight_c[n], sigma);
  }
}