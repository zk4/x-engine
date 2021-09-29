
interface Post {
  userId: string;
  tid?: int;
  title: string;
  completed: boolean;
  message: string;
}

interface ResPost {
  args: Map<string,string>;
  data: string;
  files: Map<string,string>;
  form: Map<string,string>;
  headers: Map<string,string>;
  json: Map<string,string>;
  origin: string;
  url: string;

}
