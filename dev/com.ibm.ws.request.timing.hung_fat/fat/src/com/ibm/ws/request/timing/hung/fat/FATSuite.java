/*******************************************************************************
 * Copyright (c) 2014, 2021 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/
package com.ibm.ws.request.timing.hung.fat;

import org.junit.ClassRule;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import componenttest.rules.repeater.FeatureReplacementAction;
import componenttest.rules.repeater.RepeatTests;

@RunWith(Suite.class)
@SuiteClasses({
                HungRequestTiming.class,
                HungRequestEnableThreadDumps.class
})

public class FATSuite {
    // Using the RepeatTests @ClassRule in FATSuite will cause all tests in the FAT to be run twice.
    // First without any modifications, then again with all features in all server.xml's upgraded to their EE8/EE9 equivalents.
    @ClassRule
    public static RepeatTests r = RepeatTests.withoutModification().andWith(FeatureReplacementAction.EE8_FEATURES().fullFATOnly()).andWith(FeatureReplacementAction.EE9_FEATURES().fullFATOnly());
}