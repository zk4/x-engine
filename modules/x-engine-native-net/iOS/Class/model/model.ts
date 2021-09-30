
const apiName = "Post";

@request
interface PostReq {
  userId: string;
  tid?: int;
  title: string;
  completed: boolean;
  message: string;
  moreMsg: string;
  ext: string;
}

@response
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
