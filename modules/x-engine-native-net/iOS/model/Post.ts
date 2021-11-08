
const apiName = "Post";
const apiUrl = "https://httpbin.org/post"
const apiMethod ="POST"

 
interface PostReq {
  userId: string;
  tid?: int;
  title: string;
  completed: boolean;
  message: string;
  moreMsg: string;
  ext: string;
  hello: {
    world:{
      inner:string
    }
  }
}

 
interface PostRes {
  // 参数
  args: Map<string,string>;
  data: string;
  files: Map<string,string>;
  form: Map<string,string>;
  headers: Map<string,string>;
  json: Map<string,string>;
  origin: string;
  url: string;
}
