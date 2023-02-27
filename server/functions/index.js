const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testkey);

const generateResponse = functions (intent) {
    switch (intent.status) {
        case 'requires_action':
            return {
                clientSecret: intent.clientSecret,
                requireAction: true,
                status: intent.status,
            };
        case 'requires_payment_method':
            return {
                'error': 'You card was denied, please provide a new payment method',
            };
        case 'succeeded':
            console.log('Payment succeeded.');
            return {
                clientSecret: intent.clientSecret, status: intent.status
            };
    }
    return { error: 'Failed' };
}

exports.StripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
    const { paymentMethodId, items, currency, useStripeSdk, } = req.body;

    const orderAmount = calculateOrderAmount = (items) => {
        prices = [];
        catalog = [
            { 'id': '0', 'price': 2.99 },
            { 'id': '1', 'price': 4.99 },
            { 'id': '2', 'price': 6.99 },
            { 'id': '3', 'price': 8.99 },
            { 'id': '4', 'price': 10.99 },
        ];

        items.forEach (items => {
            price = catalog.find(x => x.id == items.id).price;
            prices.push(price);
        });

        return parseInt(prices.reduce((a,b) => a + b) * 100);
    }

    try {
        if (paymentMethodId) {
            //Create a new Payment
            const params = {
                amount = orderAmount,
                confirm: true,
                confirmation_method: 'manual',
                currency: ,
                payment_method: paymentMethodId,
                use_stripe_skd: useStripeSdk,
            }
            const intent = await stripe.paymentIntents.create(params);
            console.log('Intent : ${intent}');
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400);

    } catch (e) {
        return res.send({ error: e.message });
    }
 });

exports.StripePayEndpointIntentId= functions.https.onRequest(async (req, res) => {
    const { paymentIntentId } = req.body;
    try {
        if (paymentIntentId) {
            const  intent = await stripe.paymentIntents.confirm(paymentIntentId);
            return res.send(generateResponse(intent));
        }
        return res.sendStatus
    } catch (e) {
        return res.send({ error: e.message})
    }
 });
