package io.swagger.codegen.typescript.typescriptnestjs;

import java.util.HashMap;
import java.util.Map;

import io.swagger.codegen.AbstractIntegrationTest;
import io.swagger.codegen.CodegenConfig;
import io.swagger.codegen.languages.TypeScriptNestjsClientCodegen;
import io.swagger.codegen.testutils.IntegrationTestPathsConfig;

public class TypescriptNestjsPestoreIntegrationTest extends AbstractIntegrationTest {

    @Override
    protected CodegenConfig getCodegenConfig() {
        return new TypeScriptNestjsClientCodegen();
    }

    @Override
    protected Map<String, String> configProperties() {
        Map<String, String> properties = new HashMap<>();
        properties.put("npmName", "petstore-integration-test");
        properties.put("npmVersion", "1.0.3");
        properties.put("snapshot", "false");

        return properties;
    }

    @Override
    protected IntegrationTestPathsConfig getIntegrationTestPathsConfig() {
        return new IntegrationTestPathsConfig("typescript/petstore");
    }
}
