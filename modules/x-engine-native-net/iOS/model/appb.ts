const apiName = "gm_general_login";
const apiUrlPrefix = "http://10.115.91.95:9530/bff-b";
const apiPath = "/login/ldap/1";
const apiMethod = "POST";
const apiContentType = "application/x-www-form-urlencoded"

interface x_api_gm_general_login_Req {
  ldapId?: int;
  password?: string;
  username?: string;
}
interface x_api_gm_general_login_Res {
  sessionToken?: string;
  userToken?: string;
  bizUser?: {
    avatar?: string;
    createdTime?: string;
    email?: string;
    genderType?: string;
    id?: int;
    nickname?: string;
    phoneNum?: string;
    realname?: string;
    status?: int;
    updatedTime?: string;
    userKey?: string;
  };
}
