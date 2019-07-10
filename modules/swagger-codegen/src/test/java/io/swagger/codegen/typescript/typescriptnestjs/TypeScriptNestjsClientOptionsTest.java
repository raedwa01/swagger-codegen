package io.swagger.codegen.typescript.typescriptnestjs;

import io.swagger.codegen.AbstractOptionsTest;
import io.swagger.codegen.CodegenConfig;
import io.swagger.codegen.languages.TypeScriptNestjsClientCodegen;
import io.swagger.codegen.options.TypeScriptNestjsClientOptionsProvider;
import mockit.Expectations;
import mockit.Tested;

public class TypeScriptNestjsClientOptionsTest extends AbstractOptionsTest {

    @Tested
    private TypeScriptNestjsClientCodegen clientCodegen;

    public TypeScriptNestjsClientOptionsTest() {
        super(new TypeScriptNestjsClientOptionsProvider());
    }

    @Override
    protected CodegenConfig getCodegenConfig() {
        return clientCodegen;
    }

    @SuppressWarnings("unused")
    @Override
    protected void setExpectations() {
        new Expectations(clientCodegen) {{
            clientCodegen.setSortParamsByRequiredFlag(Boolean.valueOf(TypeScriptNestjsClientOptionsProvider.SORT_PARAMS_VALUE));
            times = 1;
            clientCodegen.setModelPropertyNaming(TypeScriptNestjsClientOptionsProvider.MODEL_PROPERTY_NAMING_VALUE);
            times = 1;
            clientCodegen.setSupportsES6(Boolean.valueOf(TypeScriptNestjsClientOptionsProvider.SUPPORTS_ES6_VALUE));
            times = 1;
        }};
    }
}
