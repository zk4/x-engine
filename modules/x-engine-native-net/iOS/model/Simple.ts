
const apiName = "Simple";
const apiUrl = "https://httpbin.org/post"
const apiMethod ="POST"

 
interface SimpleReq {
  userId: string;
}

 
interface SimpleRes {
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
