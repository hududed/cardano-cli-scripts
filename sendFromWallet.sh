source functions.sh 
getInputTx $1
FROM_UTXO=${SELECTED_UTXO} # see TxHash above appended by '#TxIx'
FROM_WALLET_NAME=${SELECTED_WALLET_NAME} # as defined after ./sendfromWallet.sh ${SELECTED_WALLET_NAME}
FROM_WALLET_ADDRESS=${SELECTED_WALLET_ADDR} # $(cat ./wallets/$SELECTED_WALLET_NAME.addr)
FROM_BALANCE=${SELECTED_UTXO_LOVELACE} # See integer amount above

read -p 'Lovelace to send: ' LOVELACE_TO_SEND
read -p 'Receiving wallet name: ' TO_WALLET_NAME

TO_WALLET_ADDRESS=$(cat ./wallets/$TO_WALLET_NAME.addr)

$CARDANO_CLI transaction build \
--tx-in ${FROM_UTXO} \
--tx-out ${TO_WALLET_ADDRESS}+${LOVELACE_TO_SEND} \
--change-address ${FROM_WALLET_ADDRESS} \
--out-file tx.raw \
--alonzo-era \
--testnet-magic $TESTNET_MAGIC_NUM

$CARDANO_CLI transaction sign \
--tx-body-file tx.raw \
--signing-key-file ./wallets/$FROM_WALLET_NAME.skey \
--out-file tx.signed

$CARDANO_CLI transaction submit --tx-file tx.signed --testnet-magic $TESTNET_MAGIC_NUM

# echo $FROM_UTXO
# echo $FROM_WALLET_NAME
# echo $FROM_WALLET_ADDRESS
# echo $FROM_BALANCE
# echo $TO_WALLET_ADDRESS
