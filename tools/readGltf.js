const fs=require('fs')
var struct=JSON.parse(fs.readFileSync(process.argv[2],'utf-8'))
let out=process.argv[3]
let buffers=[]
for(let buffer of struct.buffers){
    buffers.push(Buffer.from(buffer.uri,'base64'))
}
for(let mesh of struct.meshes){
    let array=[]
    let obj={
        name:mesh.name,
        attributes:[],
        indices:{

        }
    }
    for(let attribute in mesh.primitives[0].attributes){

        let accessor=struct.accessors[mesh.primitives[0].attributes[attribute]]
        let bufferView=struct.bufferViews[accessor.bufferView]
        let tmp={
            name:attribute,
            type:accessor.componentType
        }
        array.push(getBuffer(bufferView.buffer,bufferView.byteLength,bufferView.byteOffset))
        obj.attributes.push(tmp)
    }
    let indexAccessor=struct.accessors[mesh.primitives[0].indices]
    let indexBufferView=struct.bufferViews[indexAccessor.bufferView]
    array.push(getBuffer(indexBufferView.buffer,indexBufferView.byteLength,indexBufferView.byteOffset))
    obj.indices.type=indexAccessor.componentType
    let combine= combineBuffer(array)
    obj.indices.offset=combine.attributes[combine.attributes.length-1].offset
    obj.indices.length=combine.attributes[combine.attributes.length-1].length
    for(let i=0;i<obj.attributes.length;i++){
        obj.attributes[i].offset=combine.attributes[i].offset
        obj.attributes[i].length=combine.attributes[i].length
    }   
    fs.writeFileSync(out+'/'+mesh.name+'.bin',combine.buffer)
    fs.writeFileSync(out+'/'+mesh.name+'.json',JSON.stringify(obj))
}
function getBuffer(index,length,offset){
    let target = Buffer.alloc(length)
    buffers[index].copy(target,0,offset,offset+length)
    return target
}
function combineBuffer(array){
    let result={
        buffer:Buffer.concat(array),
        attributes:[]
    }
    let tmp=0
    for(let i of array){
        let obj={
            offset:tmp,
            length:i.length
        }
        result.attributes.push(obj)
        tmp+=i.length
    }
    return result
}
function toLua(json){
    json.replace('')
}