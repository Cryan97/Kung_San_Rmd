 
data {
  int<lower=1> N;
  vector[N] height;
  vector[N] weight_c;
  vector[N] age;
}
parameters {
  real alpha;
  real beta1;
  real beta2;
  real<lower=0,upper=50> sigma;
}
model {
  vector[N] mu = alpha + beta1 * weight_c + beta2 * age;
  target += normal_lpdf(height | mu, sigma);
  target += normal_lpdf(alpha | 120, 20);
  target += normal_lpdf(beta1 | 0, 10);
  target += normal_lpdf(beta2 | 0, 10);
}
generated quantities {
  vector[N] y_pred;
  for (n in 1:N){
    y_pred[n] = normal_rng(alpha + beta1*weight_c[n] + beta2*age[n], sigma);
  }
}