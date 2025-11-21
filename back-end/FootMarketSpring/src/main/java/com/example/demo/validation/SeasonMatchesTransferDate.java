package com.example.demo.validation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = SeasonMatchesTransferDateValidator.class)
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
public @interface SeasonMatchesTransferDate {
    String message() default "Datum transfera nije u okviru izabrane sezone.";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
