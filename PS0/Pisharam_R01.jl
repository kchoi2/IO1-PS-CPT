#Step 0: Import Packages
    #import Pkg;
    #using Pkg;
    #Pkg.add("Distributions") // Importing the Distributions Package
    #Pkg.add("Plots")         // Importing the Plot Package
    #Pkg.add("DataFrame")     // Dataframe of 
    

#Step 1.1.1: Fix Parameter Values
β_1 = 0
β_2 = 2
δ = 0.2
μ = 1 #Mistake in the Problem Set?
s_D = 1 
s_S = 1

#Step 1.1.2: Generate Realizations of Shocks
using Random, Distributions
Random.seed!(123)   

d_1 = Normal(0,s_D)
d_2 = Normal(0,s_S)

ϵ_D = rand(d_1,50)
ϵ_a = rand(d_2,50)

#Step 1.1.3: Generate Price Data
ln_P = (1/(1+β_2*δ))*(δ*β_1 .+ δ*ϵ_D .+ log(μ) .- ϵ_a)
P = exp.(ln_P)

#Step 1.1.4: Use Price and Equilibrium Conditions to generate (P,Q)
ln_Q = β_1 .- β_2*ln_P .+ ϵ_D
Q = exp.(ln_Q)

#Step 1.1.5: Plot Empirical Distributions of P and Q
using Plots

plot(ln_Q, ln_P, seriestype = :scatter, title = "Log Price and Quantity", xlabel = "Log Quantity", ylabel = "Log Price")


#Step 1.2.1.1: Report OLS Estimate of β_2
simulated = DataFrame(ln_Q = ln_Q, ln_P = ln_P)
ols = lm(@formula(ln_Q ~ ln_P), simulated)

#Step 1.2.2.1: MoM

