# search in JSON string
###
obj = [
  id: "tag1"
  text: "text1"
,
  id: "tag2"
  text: "text2"
]

i = 0

while i < obj.length
  console.log obj[i].id
  i++
###

array = [ {id: 1, name: "yuri", age: 20},
        {id: 2, name: "adam", age: 30},
        {id: 3, name: "moe", age: 25} ]

#jsoned = JSON.stringify(array)

s = (user.name for user in array)

console.log s


