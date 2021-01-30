import {fetchApi} from '@/utils/ajax'
import URL from './urlConfig'

export const sendCode = data => fetchApi(URL.SEND_CODE, data, "POST");