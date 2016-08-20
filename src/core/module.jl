# Modules represent the top-level structure in an LLVM program.

export Module, dispose,
       target, setTarget, datalayout, setDatalayout

import Base: show

immutable Module
    handle::API.LLVMModuleRef

    Module(name::String) = new(API.LLVMModuleCreateWithName(name))
    Module(name::String, ctx::Context) = new(API.LLVMModuleCreateWithNameInContext(name, ctx.handle))
end

dispose(mod::Module) = API.LLVMDisposeModule(mod.handle)

function show(io::IO, mod::Module)
    if get(io, :compact, false)
        API.LLVMDumpModule(mod.handle)
    else
        # TODO: get and only print module name
        API.LLVMDumpModule(mod.handle)
    end
end

target(mod::Module) = unsafe_string(API.LLVMGetTarget(mod.handle))
setTarget(mod::Module, triple) = API.LLVMSetTarget(mod.handle, triple)

datalayout(mod::Module) = unsafe_string(API.LLVMGetDataLayout(mod.handle))
setDatalayout(mod::Module, layout) = API.LLVMSetDataLayout(mod.handle, layout)