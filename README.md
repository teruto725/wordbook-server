# README
単語帳のサーバサイドコード

# api
- signup   
curl localhost:3000/v1/users --data '{"user": {"email": "user2@example.com", "password": "mypass"}}' -v -H "Accept: application/json" -H "Content-type: application/json"
- login  
curl localhost:3000/v1/login --data 'email=user2@example.com&password=mypass'
- create wordbook  
curl -w '\n' localhost:3000/v1/wordbooks --data '{"name":"book1"}' -v -H "Authorization: 1:f9znCnsR5wYsRF4ysPBu" -H "Content-type: application/json"
- index wordbook
1curl -w '\n' localhost:3000/v1/wordbooks -v -H "Authorization: 1:f9znCnsR5wYsRF4ysPBu" -H "Content-type: application/json"
- create word  
 curl -w '\n' localhost:3000/v1/wordbooks/1/words --data '{"english":"hello","japanese":"こんにちは"}' -v -H "Authorization: 1:f9znCnsR5wYsRF4ysPBu" -H "Content-type: application/json"
- get_most_diff_word  
curl -w '\n' localhost:3000/v1/users/words/most_diff -v -H "Authorization: 2:5M4UusVmPSfdfR6AmXQs" -H "Content-type: application/json"
- get words  
curl -w '\n' localhost:3000/v1/wordbooks/1/words -v -H "Authorization: 1:f9znCnsR5wYsRF4ysPBu" -H "Content-type: application/json"
- update word  
curl -w '\n' localhost:3000/v1/users/words/1 --data '{"english":"hello","japanese":"こんにちは","difficulty":2}' -v -H "Authorization: 2:5M4UusVmPSfdfR6AmXQs" -H "Content-type: application/json"
