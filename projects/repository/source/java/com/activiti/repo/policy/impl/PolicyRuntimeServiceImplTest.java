package com.activiti.repo.policy.impl;

import junit.framework.TestCase;

import com.activiti.repo.ref.QName;

public class PolicyRuntimeServiceImplTest extends TestCase
{
    /**
     * Test data used by tests
     */
    private static final QName TEST_QNAME = QName.createQName("{testNamespace}testClassName");
    
    /**
     * Test registerBahaviour
     */
    public void testRegisterBehaviour()
    {
        PolicyRuntimeServiceImpl service = new PolicyRuntimeServiceImpl();
        
        service.registerBehaviour(
                TestPolicy.class, 
                new TestPolicyImpl(), 
                TEST_QNAME);         
    }
    
    /**
     * Test getBehaviour (by qname)
     */
    public void testGetBehaviour()
    {
        PolicyRuntimeServiceImpl service = new PolicyRuntimeServiceImpl();
        
        // Check that there are no behaviours registered
        TestPolicy policy = service.getBehaviour(TestPolicy.class, TEST_QNAME);
        assertNull(policy);
        
        // Register the an implementaion of the interface
        service.registerBehaviour(
                TestPolicy.class, 
                new TestPolicyImpl(), 
                TEST_QNAME); 
        
        // Get the policy
        policy = service.getBehaviour(TestPolicy.class, TEST_QNAME);
        assertNotNull(policy);        
        policy.OnTest("Testing the policy");    
        
        // Register another implementation of the policy
        service.registerBehaviour(TestPolicy.class, new TestPolicyImpl2(), TEST_QNAME);
        
        // Get the policy 
        policy = service.getBehaviour(TestPolicy.class, TEST_QNAME);
        assertNotNull(policy);        
        policy.OnTest("Testing the policy (there should be two!)");         
    }
    
    // TODO
    /**
     * Test getBehaviour (by class)
     */
    
    // TODO
    /**
     * Test getBehaviour (by node ref)
     */
    
    /**
     * Test policy interface
     * 
     * @author Roy Wetherall
     */
    public interface TestPolicy
    {
        public void OnTest(String value);            
    }
    
    /**
     * Test policy implementation
     * 
     * @author Roy Wetherall
     */
    public class TestPolicyImpl implements TestPolicy
    {
        public void OnTest(String value)
        {
            System.out.println(value);
        }
    }
    
    /**
     * Test policy implementation
     * 
     * @author Roy Wetherall
     */
    public class TestPolicyImpl2 implements TestPolicy
    {
        public void OnTest(String value)
        {
            System.out.println(value);
        }
    }
}
