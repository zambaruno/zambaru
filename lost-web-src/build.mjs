import {build} from 'esbuild';
import {mkdir,copyFile} from 'node:fs/promises';
await mkdir('dist/assets',{recursive:true});
await build({entryPoints:{'lost-app':'app.js','lost-guide':'guide.js'},bundle:true,minify:true,format:'iife',platform:'browser',target:['chrome100','safari15','firefox100'],outdir:'dist/assets',legalComments:'eof'});
for(const f of ['lost-guide.html','lost-app.html'])await copyFile(f,'dist/'+f);
await copyFile('lost.css','dist/assets/lost.css');
