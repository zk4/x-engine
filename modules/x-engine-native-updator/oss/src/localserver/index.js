const express = require("express")

const app = express()
app.use(require('cors')())
// 识别提交的 json 数据
app.use(express.json())

let database=[]
let id = 0
// 如果使用 monog
// https://www.bilibili.com/video/BV1t441187pL?p=3

app.get('/', async (req,res)=>{
  res.send('index')
})
let ret ={
  code: 0,
  result: "success"
}
app.post('/articles', async (req,res)=>{
  let article = {...req.body}
  article.id = id++
  database.push(article)
  console.log(database)
  res.send(ret)
})
app.delete('/articles/:id', async (req,res)=>{
  database = database.filter(article => article.id != req.params.id)
  res.send(database)
})

app.put('/articles/:id', async (req,res)=>{
  article = database.filter(article => article.id == req.params.id)
  console.log({...article,...req.body})
  database[article.id]  ={...article,...req.body}
  res.send({...ret,result:database[article.id]})
})

app.listen(3001,()=>{
  console.log("http://localhost:3001/")
})
