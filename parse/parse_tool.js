var https = require('https');

// var args = process.argv.slice(2);
// console.log('Hello ' + args.join(' ') + '!');

var convoID = 785605924898632
var access_token = "EAACEdEose0cBANFyRhIsy3I38bK0TPOT59zulBcDmXm9s8ukqcm1Ww6ZCk7IcEuj2REZC0GT0oQGz4kxKtMtvDEKKxKyn5F9D84pkJVXhPXRY4yaVNoxs4ZAKzkaZCudMtVEIo0QvkT6LeyekggOtOpvwq8ZBhcPXP1TYXqadQQZDZD"

var p = '/v2.1/' + convoID + '?fields=to%2Ccomments.limit(1000)&access_token=' + access_token

var o = {
  host: 'graph.facebook.com',
  path: p,
  method: 'GET'
};

var convo = []
var threads_parsed = 0
var participant1
var participant2

function getTestPersonaLoginCredentials(callback, options) {

    return https.get(options, function(response) {
        // Continuously update stream with data
        var body = '';
        response.on('data', function(d) {
            body += d;
        });
        response.on('end', function() {
            // Data reception is done, do whatever with it!
            var parsed = JSON.parse(body);
            if (!participant1 && !participant2){
            	participant1 = parsed.to.data[0].id
            	participant2 = parsed.to.data[1].id
            }
            callback(parsed);
        });
    })
    .on('error', (e) => {
  		console.error(e);
	})
}

function callback_fn(parsed) {
	console.log("============================")
	console.log(parsed.comments.data.length)

	for (var i = 0; i<parsed.comments.data.length; i++){
		var sender = parsed.comments.data[i].from.id
		var receiver = sender == participant1 ? participant2 : participant1

		m = {
			"sender_id": sender,
			"receiver_id": receiver,
			"text": parsed.comments.data[i].message,
			"timestamp": parsed.comments.data[i].created_time
		}

		convo.push(m)
	}
	o = parsed.comments.paging.next
	console.log(convo.length)
}

for (var j = 0; j < 10; j++ ){
	getTestPersonaLoginCredentials(callback_fn,o);
}

