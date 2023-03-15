
data {
  int<lower=0> N; //number of regions
  int y[N]; //deaths
  vector[N] log_e; //log of expected deaths
  vector[N] x; //proportions of outside workers
}


parameters {
vector[N] alpha;
real beta;
}

transformed parameters{
  vector[N] log_theta;
  log_theta = alpha + beta*x;
}

model {
y ~ poisson_log(log_theta + log_e);
alpha ~ normal(0,1);
beta ~ normal(0,1);
}

