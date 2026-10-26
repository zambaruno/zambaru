export const PAGE_SIZE=48;
export const FIND_FIELDS='id,finder_id,image_path,description,place_label,status,created_at';
export function feedQuery(db,{userId,mine=false,search='',offset=0}={}){let q=db.from('finds').select(FIND_FIELDS).order('created_at',{ascending:false});if(mine){if(!userId)throw Error('Authentication required');q=q.eq('finder_id',userId)}else q=q.neq('status','returned');if(search.trim())q=q.ilike('description','%'+search.trim().replace(/[\\%_]/g,'\\$&')+'%');return q.range(offset,offset+PAGE_SIZE-1);}
export function photoPath(userId,id){if(!/^[a-f0-9-]{36}$/i.test(userId)||!/^[a-f0-9-]{36}$/i.test(id))throw Error('Invalid identity');return userId+'/'+id+'.jpg';}
export function validPhoto(file){return !!file&&['image/jpeg','image/png','image/webp'].includes(file.type)&&file.size>0&&file.size<=25*1024*1024;}
export function canClaim(item,user){return !!user&&item.finder_id!==user.id&&item.status!=='returned';}
