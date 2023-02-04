# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "chore: modules"

# Install the Modules
install :;
	forge install --no-commit foundry-rs/forge-std

# Update Dependencies
update:; forge update

# Builds
build  :; forge clean && forge build --optimize --optimize-runs 200

# Lint
lint :; solhint './src/**/*.sol'

test :; forge test -vvv

# replit
setup :; curl -L http://foundry.paradigm.xyz | sh && ~/.foundry/bin/foundryup
