
data {
  int<lower=0> N; // number of years
  int<lower=0> S; // number of states
  matrix[N, S] y; // log entries per captia
  int<lower=0> K; // number of splines
  matrix[N, K] B; //splines
}


parameters {
  matrix[K,S] alpha;
  vector<lower=0>[S] sigma_alpha;
  vector<lower=0>[S] sigma_y;
}

transformed parameters {
  matrix[N,S] mu;
  
  for(i in 1:N){
    for(s in 1:S){
      mu[i,s] = B[i,]*alpha[,s];
    }
  }
  
}

model {
  
  for (s in 1:S){
   y[,s] ~ normal(mu[,s], sigma_y[s]); 
   alpha[1,s] ~ normal(0, sigma_alpha[s]);
   alpha[2,s] ~ normal(alpha[1,s], sigma_alpha[s]);
   alpha[3:K, s] ~ normal(2*alpha[2:(K-1), s] - alpha[1:(K-2), s], sigma_alpha[s]);
  }
  sigma_y ~ normal(0,1);
  sigma_alpha ~ normal(0,1);
}

