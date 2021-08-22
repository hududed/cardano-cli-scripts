ADDRESS=$1
KEY=$2

curl -v -XPOST "https://faucet.alonzo-purple.dev.cardano.org/send-money/$ADDRESS?apiKey=$KEY"
